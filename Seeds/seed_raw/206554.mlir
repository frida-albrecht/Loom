module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<189> : tensor<8x7x7x5xi16>}> : () -> tensor<8x7x7x5xi16>
    %1 = tosa.abs %0 : (tensor<8x7x7x5xi16>) -> tensor<8x7x7x5xi16>
    %2 = tosa.reduce_sum %1 {axis = 3 : i32} : (tensor<8x7x7x5xi16>) -> tensor<8x7x7x1xi16>
    %cast = tensor.cast %2 : tensor<8x7x7x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

