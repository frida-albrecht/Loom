module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.436600e+02> : tensor<6x4xf32>}> : () -> tensor<6x4xf32>
    %1 = "tosa.const"() <{values = dense<163> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<13> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.floor %0 : (tensor<6x4xf32>) -> tensor<6x4xf32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<6x4xf32>) -> tensor<6x4xf32>
    %5 = tosa.pow %4, %4 : (tensor<6x4xf32>, tensor<6x4xf32>) -> tensor<6x4xf32>
    %6 = tosa.const_shape  {values = dense<24> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.reshape %5, %6 : (tensor<6x4xf32>, !tosa.shape<1>) -> tensor<24xf32>
    %8 = tosa.rsqrt %7 : (tensor<24xf32>) -> tensor<24xf32>
    %9 = tosa.logical_right_shift %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.reciprocal %8 : (tensor<24xf32>) -> tensor<24xf32>
    %11 = tosa.bitwise_not %9 : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %10 : tensor<24xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

