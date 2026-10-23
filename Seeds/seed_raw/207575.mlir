module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<157> : tensor<1x10x9x7xi16>}> : () -> tensor<1x10x9x7xi16>
    %1 = tosa.reverse %0 {axis = 2 : i32} : (tensor<1x10x9x7xi16>) -> tensor<1x10x9x7xi16>
    %cast = tensor.cast %1 : tensor<1x10x9x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

