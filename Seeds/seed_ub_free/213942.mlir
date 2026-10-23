module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<123> : tensor<7x3x10xi16>}> : () -> tensor<7x3x10xi16>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<7x3x10xi16>) -> tensor<7x3x1xi16>
    %2 = tosa.add %1, %1 : (tensor<7x3x1xi16>, tensor<7x3x1xi16>) -> tensor<7x3x1xi16>
    %3 = tosa.identity %2 : (tensor<7x3x1xi16>) -> tensor<7x3x1xi16>
    %cast = tensor.cast %3 : tensor<7x3x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

