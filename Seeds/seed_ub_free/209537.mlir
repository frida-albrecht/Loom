module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<8x1x9x5xi32>}> : () -> tensor<8x1x9x5xi32>
    %1 = "tosa.const"() <{values = dense<-1.314100e+02> : tensor<2x2x3xf32>}> : () -> tensor<2x2x3xf32>
    %2 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<8x1x9x5xi32>) -> tensor<8x1x9x1xi32>
    %3 = tosa.reverse %2 {axis = 3 : i32} : (tensor<8x1x9x1xi32>) -> tensor<8x1x9x1xi32>
    %4 = tosa.exp %1 : (tensor<2x2x3xf32>) -> tensor<2x2x3xf32>
    %5 = tosa.bitwise_xor %3, %3 : (tensor<8x1x9x1xi32>, tensor<8x1x9x1xi32>) -> tensor<8x1x9x1xi32>
    %6 = tosa.bitwise_xor %5, %2 : (tensor<8x1x9x1xi32>, tensor<8x1x9x1xi32>) -> tensor<8x1x9x1xi32>
    %7 = tosa.reciprocal %4 : (tensor<2x2x3xf32>) -> tensor<2x2x3xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %10 = tosa.negate %7, %8, %9 : (tensor<2x2x3xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x2x3xf32>
    %11 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<2x2x3xf32>) -> tensor<1x2x3xf32>
    %12 = tosa.add %10, %7 : (tensor<2x2x3xf32>, tensor<2x2x3xf32>) -> tensor<2x2x3xf32>
    %13 = tosa.rsqrt %11 : (tensor<1x2x3xf32>) -> tensor<1x2x3xf32>
    %14 = tosa.bitwise_xor %5, %3 : (tensor<8x1x9x1xi32>, tensor<8x1x9x1xi32>) -> tensor<8x1x9x1xi32>
    %cast = tensor.cast %6 : tensor<8x1x9x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<2x2x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %13 : tensor<1x2x3xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %14 : tensor<8x1x9x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}

