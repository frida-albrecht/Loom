module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7> : tensor<i8>}> : () -> tensor<i8>
    %1 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<i8>, !tosa.shape<4>) -> tensor<1x1x1x1xi8>
    %cast = tensor.cast %2 : tensor<1x1x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

