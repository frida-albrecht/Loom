module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<3x3x7xi8>}> : () -> tensor<3x3x7xi8>
    %1 = "tosa.const"() <{values = dense<3.960000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %2 = "tosa.const"() <{values = dense<-1.343500e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.argmax %0 {axis = 0 : i32} : (tensor<3x3x7xi8>) -> tensor<3x7xi32>
    %4 = tosa.add %3, %3 : (tensor<3x7xi32>, tensor<3x7xi32>) -> tensor<3x7xi32>
    %5 = tosa.pow %1, %2 : (tensor<6xf32>, tensor<1xf32>) -> tensor<6xf32>
    %6 = tosa.bitwise_and %4, %3 : (tensor<3x7xi32>, tensor<3x7xi32>) -> tensor<3x7xi32>
    %7 = tosa.abs %5 : (tensor<6xf32>) -> tensor<6xf32>
    %8 = tosa.logical_left_shift %6, %3 : (tensor<3x7xi32>, tensor<3x7xi32>) -> tensor<3x7xi32>
    %cast = tensor.cast %7 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<3x7xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

