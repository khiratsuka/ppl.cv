include(${HPCC_DEPS_DIR}/hpcc/cmake/cuda-common.cmake)

if(PPLCV_USE_MSVC_STATIC_RUNTIME)
    hpcc_cuda_use_msvc_static_runtime()
endif()

set(_NVCC_FLAGS )
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_60,code=sm_60")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_61,code=sm_61")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_70,code=sm_70")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_72,code=sm_72")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_75,code=sm_75")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_80,code=sm_80")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_86,code=sm_86")
set(_NVCC_FLAGS "${_NVCC_FLAGS} -gencode arch=compute_87,code=sm_87")


set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} ${_NVCC_FLAGS}")

# --------------------------------------------------------------------------- #

file(GLOB PPLCV_CUDA_PUBLIC_HEADERS src/ppl/cv/cuda/*.h)
install(FILES ${PPLCV_CUDA_PUBLIC_HEADERS}
    DESTINATION include/ppl/cv/cuda)

list(APPEND PPLCV_COMPILE_DEFINITIONS PPLCV_USE_CUDA)

file(GLOB PPLCV_CUDA_SRC src/ppl/cv/cuda/*.cpp src/ppl/cv/cuda/utility/*.cpp)
file(GLOB PPLCV_CUDA_CU  src/ppl/cv/cuda/*.cu)
list(APPEND PPLCV_SRC ${PPLCV_CUDA_SRC} ${PPLCV_CUDA_CU})
list(APPEND PPLCV_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CUDA_INCLUDE_DIRS}>)
list(APPEND PPLCV_LINK_LIBRARIES $<BUILD_INTERFACE:${CUDA_LIBRARIES}>)

# glog benchmark and unittest sources
file(GLOB PPLCV_CUDA_BENCHMARK_SRC src/ppl/cv/cuda/*_benchmark.cpp)
file(GLOB PPLCV_CUDA_UNITTEST_SRC src/ppl/cv/cuda/*_unittest.cpp)
list(APPEND PPLCV_BENCHMARK_SRC ${PPLCV_CUDA_BENCHMARK_SRC})
list(APPEND PPLCV_UNITTEST_SRC ${PPLCV_CUDA_UNITTEST_SRC})
