#                      Data Parallel Control (dpCtl)
#
# Copyright 2020-2021 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# distutils: language = c++
# cython: language_level=3

"""This file defines the Cython extern types for the functions and opaque data
types defined by dpctl's C API.
"""

from libcpp cimport bool
from libc.stdint cimport uint32_t


cdef extern from "dpctl_utils.h":
    cdef void DPCTLCString_Delete(const char *str)
    cdef void DPCTLSize_t_Array_Delete(size_t *arr)


cdef extern from "dpctl_sycl_enum_types.h":
    cdef enum _backend_type 'DPCTLSyclBackendType':
        _ALL_BACKENDS    'DPCTL_ALL_BACKENDS'
        _CUDA            'DPCTL_CUDA'
        _HOST            'DPCTL_HOST'
        _LEVEL_ZERO      'DPCTL_LEVEL_ZERO'
        _OPENCL          'DPCTL_OPENCL'
        _UNKNOWN_BACKEND 'DPCTL_UNKNOWN_BACKEND'

    ctypedef _backend_type DPCTLSyclBackendType

    cdef enum _device_type 'DPCTLSyclDeviceType':
        _ACCELERATOR    'DPCTL_ACCELERATOR'
        _ALL_DEVICES    'DPCTL_ALL'
        _AUTOMATIC      'DPCTL_AUTOMATIC'
        _CPU            'DPCTL_CPU'
        _CUSTOM         'DPCTL_CUSTOM'
        _GPU            'DPCTL_GPU'
        _HOST_DEVICE    'DPCTL_HOST_DEVICE'
        _UNKNOWN_DEVICE 'DPCTL_UNKNOWN_DEVICE'

    ctypedef _device_type DPCTLSyclDeviceType

    cdef enum _arg_data_type 'DPCTLKernelArgType':
        _CHAR               'DPCTL_CHAR',
        _SIGNED_CHAR        'DPCTL_SIGNED_CHAR',
        _UNSIGNED_CHAR      'DPCTL_UNSIGNED_CHAR',
        _SHORT              'DPCTL_SHORT',
        _INT                'DPCTL_INT',
        _UNSIGNED_INT       'DPCTL_UNSIGNED_INT',
        _UNSIGNED_INT8      'DPCTL_UNSIGNED_INT8',
        _LONG               'DPCTL_LONG',
        _UNSIGNED_LONG      'DPCTL_UNSIGNED_LONG',
        _LONG_LONG          'DPCTL_LONG_LONG',
        _UNSIGNED_LONG_LONG 'DPCTL_UNSIGNED_LONG_LONG',
        _SIZE_T             'DPCTL_SIZE_T',
        _FLOAT              'DPCTL_FLOAT',
        _DOUBLE             'DPCTL_DOUBLE',
        _LONG_DOUBLE        'DPCTL_DOUBLE',
        _VOID_PTR           'DPCTL_VOID_PTR'

    ctypedef _arg_data_type DPCTLKernelArgType

    cdef enum _aspect_type 'DPCTLSyclAspectType':
        _host                               'host',
        _cpu                                'cpu',
        _gpu                                'gpu',
        _accelerator                        'accelerator',
        _custom                             'custom',
        _fp16                               'fp16',
        _fp64                               'fp64',
        _int64_base_atomics                 'int64_base_atomics',
        _int64_extended_atomics             'int64_extended_atomics',
        _image                              'image',
        _online_compiler                    'online_compiler',
        _online_linker                      'online_linker',
        _queue_profiling                    'queue_profiling',
        _usm_device_allocations             'usm_device_allocations',
        _usm_host_allocations               'usm_host_allocations',
        _usm_shared_allocations             'usm_shared_allocations',
        _usm_restricted_shared_allocations  'usm_restricted_shared_allocations',
        _usm_system_allocator               'usm_system_allocator'

    ctypedef _aspect_type DPCTLSyclAspectType


cdef extern from "dpctl_sycl_types.h":
    cdef struct DPCTLOpaqueSyclContext
    cdef struct DPCTLOpaqueSyclDevice
    cdef struct DPCTLOpaqueSyclDeviceSelector
    cdef struct DPCTLOpaqueSyclEvent
    cdef struct DPCTLOpaqueSyclKernel
    cdef struct DPCTLOpaqueSyclPlatform
    cdef struct DPCTLOpaqueSyclProgram
    cdef struct DPCTLOpaqueSyclQueue
    cdef struct DPCTLOpaqueSyclUSM

    ctypedef DPCTLOpaqueSyclContext        *DPCTLSyclContextRef
    ctypedef DPCTLOpaqueSyclDevice         *DPCTLSyclDeviceRef
    ctypedef DPCTLOpaqueSyclDeviceSelector *DPCTLSyclDeviceSelectorRef
    ctypedef DPCTLOpaqueSyclEvent          *DPCTLSyclEventRef
    ctypedef DPCTLOpaqueSyclKernel         *DPCTLSyclKernelRef
    ctypedef DPCTLOpaqueSyclPlatform       *DPCTLSyclPlatformRef
    ctypedef DPCTLOpaqueSyclProgram        *DPCTLSyclProgramRef
    ctypedef DPCTLOpaqueSyclQueue          *DPCTLSyclQueueRef
    ctypedef DPCTLOpaqueSyclUSM            *DPCTLSyclUSMRef


cdef extern from "dpctl_sycl_device_interface.h":
    cdef bool DPCTLDevice_AreEq(const DPCTLSyclDeviceRef DRef1,
                                const DPCTLSyclDeviceRef DRef2)
    cdef DPCTLSyclDeviceRef DPCTLDevice_Copy(const DPCTLSyclDeviceRef DRef)
    cdef DPCTLSyclDeviceRef DPCTLDevice_Create()
    cdef DPCTLSyclDeviceRef DPCTLDevice_CreateFromSelector(
        const DPCTLSyclDeviceSelectorRef DSRef)
    cdef void DPCTLDevice_Delete(DPCTLSyclDeviceRef DRef)
    cdef DPCTLSyclBackendType DPCTLDevice_GetBackend(
        const DPCTLSyclDeviceRef DRef)
    cdef DPCTLSyclDeviceType DPCTLDevice_GetDeviceType(
        const DPCTLSyclDeviceRef DRef)
    cdef const char *DPCTLDevice_GetDriverInfo(const DPCTLSyclDeviceRef DRef)
    cdef uint32_t DPCTLDevice_GetMaxComputeUnits(const DPCTLSyclDeviceRef DRef)
    cdef uint32_t DPCTLDevice_GetMaxNumSubGroups(const DPCTLSyclDeviceRef DRef)
    cdef size_t DPCTLDevice_GetMaxWorkGroupSize(const DPCTLSyclDeviceRef DRef)
    cdef uint32_t DPCTLDevice_GetMaxWorkItemDims(const DPCTLSyclDeviceRef DRef)
    cdef size_t *DPCTLDevice_GetMaxWorkItemSizes(const DPCTLSyclDeviceRef DRef)
    cdef const char *DPCTLDevice_GetName(const DPCTLSyclDeviceRef DRef)
    cdef DPCTLSyclPlatformRef DPCTLDevice_GetPlatform(
        const DPCTLSyclDeviceRef DRef)
    cdef const char *DPCTLDevice_GetVendorName(const DPCTLSyclDeviceRef DRef)
    cdef bool DPCTLDevice_IsAccelerator(const DPCTLSyclDeviceRef DRef)
    cdef bool DPCTLDevice_IsCPU(const DPCTLSyclDeviceRef DRef)
    cdef bool DPCTLDevice_IsGPU(const DPCTLSyclDeviceRef DRef)
    cdef bool DPCTLDevice_IsHost(const DPCTLSyclDeviceRef DRef)
    cdef bool DPCTLDevice_IsHostUnifiedMemory(const DPCTLSyclDeviceRef DRef)
    cpdef bool DPCTLDevice_HasAspect(
        const DPCTLSyclDeviceRef DRef, DPCTLSyclAspectType AT)


cdef extern from "dpctl_sycl_device_manager.h":
    cdef struct DPCTLDeviceVector
    ctypedef DPCTLDeviceVector *DPCTLDeviceVectorRef

    cdef void DPCTLDeviceVector_Delete(DPCTLDeviceVectorRef DVRef)
    cdef void DPCTLDeviceVector_Clear(DPCTLDeviceVectorRef DVRef)
    cdef size_t DPCTLDeviceVector_Size(DPCTLDeviceVectorRef DVRef)
    cdef DPCTLSyclDeviceRef DPCTLDeviceVector_GetAt(
        DPCTLDeviceVectorRef DVRef,
        size_t index)
    cdef DPCTLDeviceVectorRef DPCTLDeviceMgr_GetDevices(int device_identifier)
    cdef size_t DPCTLDeviceMgr_GetNumDevices(int device_identifier)
    cdef void DPCTLDeviceMgr_PrintDeviceInfo(const DPCTLSyclDeviceRef DRef)


cdef extern from "dpctl_sycl_device_selector_interface.h":
    DPCTLSyclDeviceSelectorRef DPCTLAcceleratorSelector_Create()
    DPCTLSyclDeviceSelectorRef DPCTLDefaultSelector_Create()
    DPCTLSyclDeviceSelectorRef DPCTLCPUSelector_Create()
    DPCTLSyclDeviceSelectorRef DPCTLFilterSelector_Create(
        const char *filter_str)
    DPCTLSyclDeviceSelectorRef DPCTLGPUSelector_Create()
    DPCTLSyclDeviceSelectorRef DPCTLHostSelector_Create()
    void DPCTLDeviceSelector_Delete(DPCTLSyclDeviceSelectorRef DSRef)


cdef extern from "dpctl_sycl_event_interface.h":
    cdef void DPCTLEvent_Wait(DPCTLSyclEventRef ERef)
    cdef void DPCTLEvent_Delete(DPCTLSyclEventRef ERef)


cdef extern from "dpctl_sycl_kernel_interface.h":
    cdef const char* DPCTLKernel_GetFunctionName(const DPCTLSyclKernelRef KRef)
    cdef size_t DPCTLKernel_GetNumArgs(const DPCTLSyclKernelRef KRef)
    cdef void DPCTLKernel_Delete(DPCTLSyclKernelRef KRef)


cdef extern from "dpctl_sycl_platform_interface.h":
    cdef void DPCTLPlatform_Delete()
    cdef size_t DPCTLPlatform_GetNumNonHostPlatforms()
    cdef void DPCTLPlatform_DumpInfo()
    cdef size_t DPCTLPlatform_GetNumNonHostBackends()
    cdef DPCTLSyclBackendType *DPCTLPlatform_GetListOfNonHostBackends()
    cdef void DPCTLPlatform_DeleteListOfBackends(DPCTLSyclBackendType * BEs)


cdef extern from "dpctl_sycl_context_interface.h":
    cdef bool DPCTLContext_AreEq(const DPCTLSyclContextRef CtxRef1,
                                 const DPCTLSyclContextRef CtxRef2)
    cdef DPCTLSyclBackendType DPCTLContext_GetBackend(
        const DPCTLSyclContextRef CtxRef)
    cdef void DPCTLContext_Delete(DPCTLSyclContextRef CtxRef)


cdef extern from "dpctl_sycl_program_interface.h":
    cdef DPCTLSyclProgramRef DPCTLProgram_CreateFromSpirv(
        const DPCTLSyclContextRef Ctx,
        const void *IL,
        size_t Length,
        const char *CompileOpts)
    cdef DPCTLSyclProgramRef DPCTLProgram_CreateFromOCLSource(
        const DPCTLSyclContextRef Ctx,
        const char *Source,
        const char *CompileOpts)
    cdef DPCTLSyclKernelRef DPCTLProgram_GetKernel(
        DPCTLSyclProgramRef PRef,
        const char *KernelName)
    cdef bool DPCTLProgram_HasKernel(DPCTLSyclProgramRef PRef,
                                     const char *KernelName)
    cdef void DPCTLProgram_Delete(DPCTLSyclProgramRef PRef)


cdef extern from "dpctl_sycl_queue_interface.h":
    cdef bool DPCTLQueue_AreEq(const DPCTLSyclQueueRef QRef1,
                               const DPCTLSyclQueueRef QRef2)
    cdef void DPCTLQueue_Delete(DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclBackendType DPCTLQueue_GetBackend(const DPCTLSyclQueueRef Q)
    cdef DPCTLSyclContextRef DPCTLQueue_GetContext(const DPCTLSyclQueueRef Q)
    cdef DPCTLSyclDeviceRef DPCTLQueue_GetDevice(const DPCTLSyclQueueRef Q)
    cdef DPCTLSyclEventRef  DPCTLQueue_SubmitRange(
        const DPCTLSyclKernelRef Ref,
        const DPCTLSyclQueueRef QRef,
        void **Args,
        const DPCTLKernelArgType *ArgTypes,
        size_t NArgs,
        const size_t Range[3],
        size_t NDims,
        const DPCTLSyclEventRef *DepEvents,
        size_t NDepEvents)
    cdef DPCTLSyclEventRef DPCTLQueue_SubmitNDRange(
        const DPCTLSyclKernelRef Ref,
        const DPCTLSyclQueueRef QRef,
        void **Args,
        const DPCTLKernelArgType *ArgTypes,
        size_t NArgs,
        const size_t gRange[3],
        const size_t lRange[3],
        size_t NDims,
        const DPCTLSyclEventRef *DepEvents,
        size_t NDepEvents)
    cdef void DPCTLQueue_Wait(const DPCTLSyclQueueRef QRef)
    cdef void DPCTLQueue_Memcpy(
        const DPCTLSyclQueueRef Q,
        void *Dest,
        const void *Src,
        size_t Count)
    cdef void DPCTLQueue_Prefetch(
        const DPCTLSyclQueueRef Q,
        const void *Src,
        size_t Count)
    cdef void DPCTLQueue_MemAdvise(
        const DPCTLSyclQueueRef Q,
        const void *Src,
        size_t Count,
        int Advice)


cdef extern from "dpctl_sycl_queue_manager.h":
    cdef DPCTLSyclQueueRef DPCTLQueueMgr_GetCurrentQueue()
    cdef size_t DPCTLQueueMgr_GetNumQueues(DPCTLSyclBackendType BETy,
                                           DPCTLSyclDeviceType DeviceTy)
    cdef size_t DPCTLQueueMgr_GetNumActivatedQueues()
    cdef DPCTLSyclQueueRef DPCTLQueueMgr_GetQueue(
        DPCTLSyclBackendType BETy,
        DPCTLSyclDeviceType DeviceTy,
        size_t DNum)
    cdef bool DPCTLQueueMgr_IsCurrentQueue(const DPCTLSyclQueueRef QRef)
    cdef void DPCTLQueueMgr_PopQueue()
    cdef DPCTLSyclQueueRef DPCTLQueueMgr_PushQueue(
        DPCTLSyclBackendType BETy,
        DPCTLSyclDeviceType DeviceTy,
        size_t DNum)
    cdef DPCTLSyclQueueRef DPCTLQueueMgr_SetAsDefaultQueue(
        DPCTLSyclBackendType BETy,
        DPCTLSyclDeviceType DeviceTy,
        size_t DNum)
    cdef DPCTLSyclQueueRef DPCTLQueueMgr_GetQueueFromContextAndDevice(
        DPCTLSyclContextRef CRef,
        DPCTLSyclDeviceRef DRef)


cdef extern from "dpctl_sycl_usm_interface.h":
    cdef DPCTLSyclUSMRef DPCTLmalloc_shared(
        size_t size,
        DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclUSMRef DPCTLmalloc_host(
        size_t size,
        DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclUSMRef DPCTLmalloc_device(size_t size, DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclUSMRef DPCTLaligned_alloc_shared(
        size_t alignment,
        size_t size,
        DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclUSMRef DPCTLaligned_alloc_host(
        size_t alignment,
        size_t size,
        DPCTLSyclQueueRef QRef)
    cdef DPCTLSyclUSMRef DPCTLaligned_alloc_device(
        size_t alignment,
        size_t size,
        DPCTLSyclQueueRef QRef)
    cdef void DPCTLfree_with_queue(
        DPCTLSyclUSMRef MRef,
        DPCTLSyclQueueRef QRef)
    cdef void DPCTLfree_with_context(
        DPCTLSyclUSMRef MRef,
        DPCTLSyclContextRef CRef)
    cdef const char* DPCTLUSM_GetPointerType(
        DPCTLSyclUSMRef MRef,
        DPCTLSyclContextRef CRef)
    cdef DPCTLSyclDeviceRef DPCTLUSM_GetPointerDevice(
        DPCTLSyclUSMRef MRef,
        DPCTLSyclContextRef CRef)
