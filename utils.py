import os
import sys
from contextlib import contextmanager
try:
    import ctypes
    from ctypes.util import find_library
except ImportError:
    libc = None
else:
    try:
        libc = ctypes.cdll.msvcrt # Windows
    except OSError:
        libc = ctypes.cdll.LoadLibrary(find_library('c'))

def flush(stream):
    try:
        libc.fflush(None)
        stream.flush()
    except (AttributeError, ValueError, IOError):
        pass # unsupported

def fileno(file_or_fd):
    fd = getattr(file_or_fd, 'fileno', lambda: file_or_fd)()
    if not isinstance(fd, int):
        raise ValueError("Expected a file (`.fileno()`) or a file descriptor")
    return fd

# https://stackoverflow.com/a/22434262/2754040
@contextmanager
def stdout_redirected(to=os.devnull, stdout=None):
    if stdout is None:
       stdout = sys.stdout

    stdout_fd = fileno(stdout)
    # copy stdout_fd before it is overwritten
    #NOTE: `copied` is inheritable on Windows when duplicating a standard stream
    with os.fdopen(os.dup(stdout_fd), 'wb') as copied: 
        flush(stdout)  # flush library buffers that dup2 knows nothing about
        try:
            os.dup2(fileno(to), stdout_fd)  # $ exec >&to
        except ValueError:  # filename
            with open(to, 'wb') as to_file:
                os.dup2(to_file.fileno(), stdout_fd)  # $ exec > to
        try:
            yield stdout # allow code to be run with the redirected stdout
        finally:
            # restore stdout to its previous value
            #NOTE: dup2 makes stdout_fd inheritable unconditionally
            flush(stdout)
            os.dup2(copied.fileno(), stdout_fd)  # $ exec >&copied
