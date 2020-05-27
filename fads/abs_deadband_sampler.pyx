# distutils: define_macros=NPY_NO_DEPRECATED_API=NPY_1_7_API_VERSION
cimport numpy as np
def hyst_event_detector_cy32(np.float32_t[::1] sig, 
                             np.float32_t[::1] on, 
                             np.float32_t[::1] off, 
                             double thr):
    cdef:
        long i
        double val
        double last_event
    last_event = sig[0]
    for i in range(sig.shape[0]):
        val = sig[i]
        if val >= (last_event + thr):
            on[i] = 1
            last_event = last_event + thr 
        elif val < (last_event - thr):
            off[i] = 1
            last_event = last_event - thr
    return on, off

def hyst_event_detector_cy64(np.float64_t[::1] sig, 
                             np.float64_t[::1] on, 
                             np.float64_t[::1] off, 
                             double thr):
    cdef:
        long i
        double val
        double last_event
    last_event = sig[0]
    for i in range(sig.shape[0]):
        val = sig[i]
        if val >= (last_event + thr):
            on[i] = 1
            last_event = last_event + thr 
        elif val < (last_event - thr):
            off[i] = 1
            last_event = last_event - thr
    return on, off
