module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<4x2x8x9xi8>}> : () -> tensor<4x2x8x9xi8>
    %1 = tosa.const_shape  {values = dense<[1, 1, 3, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<4x2x8x9xi8>, !tosa.shape<4>) -> tensor<4x2x24x27xi8>
    %cast = tensor.cast %2 : tensor<4x2x24x27xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

