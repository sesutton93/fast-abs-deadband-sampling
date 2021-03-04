cimport numpy as cnp
import numpy as np

def hyst_event_detector_cy32(cnp.float32_t[::1] sig, 
                           cnp.float32_t[::1] events, 
                           double thr):
    cdef:
        size_t i
        double val
        double last_event
    last_event = sig[0]
    for i in range(sig.shape[0]):
        val = sig[i]
        if val >= (last_event + thr):
            events[i] = 1
            last_event = last_event + thr 
        elif val < (last_event - thr):
            events[i] = -1
            last_event = last_event - thr
    return events

def hyst_event_detector_cy64(cnp.float64_t[::1] sig, 
                           cnp.float64_t[::1] events, 
                           double thr):
    cdef:
        size_t i
        double val
        double last_event
    last_event = sig[0]
    for i in range(sig.shape[0]):
        val = sig[i]
        if val >= (last_event + thr):
            events[i] = 1
            last_event = last_event + thr 
        elif val < (last_event - thr):
            events[i] = -1
            last_event = last_event - thr
    return events

def get_bouts_cy32(cnp.int32_t[:,:] events, cnp.int32_t[:,:] bouts):
    cdef:
        cnp.int32_t[:] first_event
        cnp.int32_t[:] bout = np.empty(3, dtype=np.int32)
        size_t i
        size_t j
    first_event = events[0,:]
    j = 0
    for i in range(events.shape[0]):
        if events[i,1] != first_event[1]:
            bout[0] = first_event[0]
            bout[1] = events[i-1][0]
            bout[2] = first_event[1]
            bouts[j] = bout
            j += 1
            first_event = events[i,:]
        if i == events.shape[0] - 1:
            bout[0] = first_event[0]
            bout[1] = events[-1][0]
            bout[2] = first_event[1]
            bouts[j] = bout
            j += 1
    bouts = bouts[:j]
    return bouts

def get_bouts_cy64(cnp.int64_t[:,:] events, cnp.int64_t[:,:] bouts):
    cdef:
        cnp.int64_t[:] first_event
        cnp.int64_t[:] bout = np.empty(3, dtype=np.int64)
        size_t i
        size_t j
    first_event = events[0,:]
    j = 0
    for i in range(events.shape[0]):
        if events[i,1] != first_event[1]:
            bout[0] = first_event[0]
            bout[1] = events[i-1][0]
            bout[2] = first_event[1]
            bouts[j] = bout
            j += 1
            first_event = events[i,:]
        if i == events.shape[0] - 1:
            bout[0] = first_event[0]
            bout[1] = events[-1][0]
            bout[2] = first_event[1]
            bouts[j] = bout
            j += 1
    bouts = bouts[:j]
    return bouts