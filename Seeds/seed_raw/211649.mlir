module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<1.774200e+02> : tensor<7x1x5x6xf32>}> : () -> tensor<7x1x5x6xf32>
    %2 = tosa.identity %0 : (tensor<1xi8>) -> tensor<1xi8>
    %3 = tosa.floor %1 : (tensor<7x1x5x6xf32>) -> tensor<7x1x5x6xf32>
    %cast = tensor.cast %2 : tensor<1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %3 : tensor<7x1x5x6xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

