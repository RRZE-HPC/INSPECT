import os
import sys
from contextlib import contextmanager
from collections import OrderedDict
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


class Results:
    def get_free_symbols(self):
        raise NotImplementedError

    def evaluate(self, symbol_dict={}, default=None):
        raise NotImplementedError


class LayerConditionResults(Results):
    def __init__(self, lc_result_dict):
        self.result = lc_result_dict
    
    def get_free_symbols(self):
        free_symbols = set()
        for cache in self.result['cache']:
            for lc in cache:
                if hasattr(lc['condition'], 'free_symbols'):
                    free_symbols = free_symbols | lc['condition'].free_symbols
        return free_symbols
    
    def evaluate(self, symbol_dict={}, default=None):
        """
        Return list of evicts and misses per cache
        """
        if default is not None:
            symbol_dict = {s: default for s in self.get_free_symbols()}
        result = []
        for cache in self.result['cache']:
            for lc in cache:
                try:
                    if lc['condition'] is True or lc['condition'].subs(symbol_dict):
                        result.append({'misses': lc['misses'], 'evicts': lc['evicts']})
                        break
                except TypeError as e:
                    raise ValueError("Probably not all symbols were defined.") from e
            else:
                raise ValueError("Could not find any LC condition evaluating to True.")
        return result


def flatten_tuple(T):
    if not isinstance(T, tuple):
        return (T,)
    elif len(T) == 0:
        return ()
    else:
        return flatten_tuple(T[0]) + flatten_tuple(T[1:])
