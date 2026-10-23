module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.811000e+01> : tensor<1x2x7xf32>}> : () -> tensor<1x2x7xf32>
    %1 = "tosa.const"() <{values = dense<-3.625000e+01> : tensor<1x1x7xf32>}> : () -> tensor<1x1x7xf32>
    %2 = "tosa.const"() <{values = dense<153> : tensor<6xi32>}> : () -> tensor<6xi32>
    %3 = "tosa.const"() <{values = dense<-64> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.sub %0, %1 : (tensor<1x2x7xf32>, tensor<1x1x7xf32>) -> tensor<1x2x7xf32>
    %5 = tosa.intdiv %2, %3 : (tensor<6xi32>, tensor<1xi32>) -> tensor<6xi32>
    %6 = tosa.exp %4 : (tensor<1x2x7xf32>) -> tensor<1x2x7xf32>
    %7 = tosa.logical_left_shift %5, %5 : (tensor<6xi32>, tensor<6xi32>) -> tensor<6xi32>
    %8 = tosa.rsqrt %6 : (tensor<1x2x7xf32>) -> tensor<1x2x7xf32>
    %9 = tosa.exp %4 : (tensor<1x2x7xf32>) -> tensor<1x2x7xf32>
    %10 = tosa.bitwise_xor %5, %7 : (tensor<6xi32>, tensor<6xi32>) -> tensor<6xi32>
    %11 = tosa.sub %10, %10 : (tensor<6xi32>, tensor<6xi32>) -> tensor<6xi32>
    %12 = tosa.reverse %11 {axis = 0 : i32} : (tensor<6xi32>) -> tensor<6xi32>
    %13 = tosa.rsqrt %8 : (tensor<1x2x7xf32>) -> tensor<1x2x7xf32>
    %cast = tensor.cast %9 : tensor<1x2x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<6xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %13 : tensor<1x2x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

