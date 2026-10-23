module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<35> : tensor<10x5x8xi16>}> : () -> tensor<10x5x8xi16>
    %1 = tosa.identity %0 : (tensor<10x5x8xi16>) -> tensor<10x5x8xi16>
    %2 = tosa.abs %1 : (tensor<10x5x8xi16>) -> tensor<10x5x8xi16>
    %3 = tosa.abs %2 : (tensor<10x5x8xi16>) -> tensor<10x5x8xi16>
    %cast = tensor.cast %3 : tensor<10x5x8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

