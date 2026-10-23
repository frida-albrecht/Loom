module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<161> : tensor<10x5x4x1xi16>}> : () -> tensor<10x5x4x1xi16>
    %1 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<10x5x4x1xi16>) -> tensor<10x5x4x1xi16>
    %cast = tensor.cast %1 : tensor<10x5x4x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

