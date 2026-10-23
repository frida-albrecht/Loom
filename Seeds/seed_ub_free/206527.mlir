module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<157> : tensor<1x7x1x10xi16>}> : () -> tensor<1x7x1x10xi16>
    %1 = tosa.const_shape  {values = dense<[1, 3, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<1x7x1x10xi16>, !tosa.shape<4>) -> tensor<1x21x2x30xi16>
    %cast = tensor.cast %2 : tensor<1x21x2x30xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

