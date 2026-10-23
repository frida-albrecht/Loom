module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<97> : tensor<9x7x7xi16>}> : () -> tensor<9x7x7xi16>
    %1 = "tosa.const"() <{values = dense<52> : tensor<9x7x4xi16>}> : () -> tensor<9x7x4xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<9x7x7xi16>, tensor<9x7x4xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<9x7x4xi16>
    %5 = tosa.identity %4 : (tensor<9x7x4xi16>) -> tensor<9x7x4xi16>
    %cast = tensor.cast %5 : tensor<9x7x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

