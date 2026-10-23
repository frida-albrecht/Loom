module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.070700e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x3x7x9xi32>}> : () -> tensor<1x3x7x9xi32>
    %2 = "tosa.const"() <{values = dense<150> : tensor<1x3x7x9xi32>}> : () -> tensor<1x3x7x9xi32>
    %3 = tosa.tanh %0 : (tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<1x3x7x9xi32>, tensor<1x3x7x9xi32>) -> tensor<1x3x7x9xi32>
    %5 = tosa.argmax %4 {axis = 3 : i32} : (tensor<1x3x7x9xi32>) -> tensor<1x3x7xi32>
    %6 = tosa.sigmoid %3 : (tensor<6xf32>) -> tensor<6xf32>
    %7 = tosa.bitwise_not %5 : (tensor<1x3x7xi32>) -> tensor<1x3x7xi32>
    %8 = tosa.clamp %5 {max_val = 103 : i32, min_val = 13 : i32} : (tensor<1x3x7xi32>) -> tensor<1x3x7xi32>
    %9 = tosa.bitwise_xor %8, %5 : (tensor<1x3x7xi32>, tensor<1x3x7xi32>) -> tensor<1x3x7xi32>
    %10 = tosa.add %7, %9 : (tensor<1x3x7xi32>, tensor<1x3x7xi32>) -> tensor<1x3x7xi32>
    %11 = tosa.reduce_product %9 {axis = 1 : i32} : (tensor<1x3x7xi32>) -> tensor<1x1x7xi32>
    %12 = tosa.concat %10, %9 {axis = 0 : i32} : (tensor<1x3x7xi32>, tensor<1x3x7xi32>) -> tensor<2x3x7xi32>
    %cast = tensor.cast %6 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<1x1x7xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %12 : tensor<2x3x7xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

