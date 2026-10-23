module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7> : tensor<9x2x2xi8>}> : () -> tensor<9x2x2xi8>
    %1 = tosa.const_shape  {values = dense<[1, 3, 12]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<9x2x2xi8>, !tosa.shape<3>) -> tensor<1x3x12xi8>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<1x3x12xi8>) -> tensor<1x3x12xi8>
    %cast = tensor.cast %3 : tensor<1x3x12xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

