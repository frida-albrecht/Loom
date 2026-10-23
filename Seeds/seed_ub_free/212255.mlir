module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<122> : tensor<6xi16>}> : () -> tensor<6xi16>
    %1 = tosa.bitwise_not %0 : (tensor<6xi16>) -> tensor<6xi16>
    %2 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<6xi16>) -> tensor<1xi16>
    %cast = tensor.cast %2 : tensor<1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

