module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<4x7x5x8xi8>}> : () -> tensor<4x7x5x8xi8>
    %1 = "tosa.const"() <{values = dense<17> : tensor<4x7x5x1xi8>}> : () -> tensor<4x7x5x1xi8>
    %2 = "tosa.const"() <{values = dense<1.066100e+02> : tensor<9x4xf32>}> : () -> tensor<9x4xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<4x7x5x8xi8>, tensor<4x7x5x1xi8>) -> tensor<4x7x5x8xi8>
    %4 = tosa.floor %2 : (tensor<9x4xf32>) -> tensor<9x4xf32>
    %5 = tosa.bitwise_xor %3, %3 : (tensor<4x7x5x8xi8>, tensor<4x7x5x8xi8>) -> tensor<4x7x5x8xi8>
    %cast = tensor.cast %4 : tensor<9x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<4x7x5x8xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

