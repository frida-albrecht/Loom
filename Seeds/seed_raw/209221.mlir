module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.735400e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<44> : tensor<2x3x3x7xi32>}> : () -> tensor<2x3x3x7xi32>
    %2 = "tosa.const"() <{values = dense<106> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<2x3x3x7xi32>, tensor<1x1x1x1xi32>) -> tensor<2x3x3x7xi32>
    %5 = tosa.intdiv %4, %4 : (tensor<2x3x3x7xi32>, tensor<2x3x3x7xi32>) -> tensor<2x3x3x7xi32>
    %6 = tosa.reduce_sum %4 {axis = 3 : i32} : (tensor<2x3x3x7xi32>) -> tensor<2x3x3x1xi32>
    %7 = tosa.bitwise_and %5, %5 : (tensor<2x3x3x7xi32>, tensor<2x3x3x7xi32>) -> tensor<2x3x3x7xi32>
    %8 = tosa.logical_right_shift %7, %4 : (tensor<2x3x3x7xi32>, tensor<2x3x3x7xi32>) -> tensor<2x3x3x7xi32>
    %9 = tosa.exp %3 : (tensor<1xf32>) -> tensor<1xf32>
    %10 = tosa.reverse %6 {axis = 3 : i32} : (tensor<2x3x3x1xi32>) -> tensor<2x3x3x1xi32>
    %11 = tosa.add %8, %4 : (tensor<2x3x3x7xi32>, tensor<2x3x3x7xi32>) -> tensor<2x3x3x7xi32>
    %cast = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<2x3x3x1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %11 : tensor<2x3x3x7xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

