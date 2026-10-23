module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<7x10xi8>}> : () -> tensor<7x10xi8>
    %1 = tosa.const_shape  {values = dense<[5, 2, 7, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<7x10xi8>, !tosa.shape<4>) -> tensor<5x2x7x1xi8>
    %cast = tensor.cast %2 : tensor<5x2x7x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

