module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.745000e+02> : tensor<6x4xf32>}> : () -> tensor<6x4xf32>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<3xi8>}> : () -> tensor<3xi8>
    %2 = "tosa.const"() <{values = dense<7> : tensor<3xi8>}> : () -> tensor<3xi8>
    %3 = tosa.exp %0 : (tensor<6x4xf32>) -> tensor<6x4xf32>
    %4 = tosa.bitwise_and %1, %2 : (tensor<3xi8>, tensor<3xi8>) -> tensor<3xi8>
    %5 = tosa.add %4, %4 : (tensor<3xi8>, tensor<3xi8>) -> tensor<3xi8>
    %6 = tosa.logical_left_shift %5, %4 : (tensor<3xi8>, tensor<3xi8>) -> tensor<3xi8>
    %cast = tensor.cast %3 : tensor<6x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<3xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

