module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<68> : tensor<9x8xi16>}> : () -> tensor<9x8xi16>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<9x8xi16>) -> tensor<1x8xi16>
    %2 = tosa.add %1, %1 : (tensor<1x8xi16>, tensor<1x8xi16>) -> tensor<1x8xi16>
    %cast = tensor.cast %2 : tensor<1x8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

