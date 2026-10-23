module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.823600e+02> : tensor<9x4x4xf32>}> : () -> tensor<9x4x4xf32>
    %1 = "tosa.const"() <{values = dense<-8.740000e+01> : tensor<9x4x8xf32>}> : () -> tensor<9x4x8xf32>
    %2 = "tosa.const"() <{values = dense<-35> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<9> : tensor<i32>}> : () -> tensor<i32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.matmul %0, %1, %4, %5 : (tensor<9x4x4xf32>, tensor<9x4x8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<9x4x8xf32>
    %7 = tosa.logical_left_shift %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.const_shape  {values = dense<[2, 3, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %9 = tosa.tile %6, %8 : (tensor<9x4x8xf32>, !tosa.shape<3>) -> tensor<18x12x16xf32>
    %10 = tosa.add %9, %9 : (tensor<18x12x16xf32>, tensor<18x12x16xf32>) -> tensor<18x12x16xf32>
    %11 = tosa.floor %10 : (tensor<18x12x16xf32>) -> tensor<18x12x16xf32>
    %cast = tensor.cast %7 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %11 : tensor<18x12x16xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

