module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-26> : tensor<1x5xi16>}> : () -> tensor<1x5xi16>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<1x5xi16>) -> tensor<1x1xi16>
    %2 = tosa.logical_left_shift %1, %1 : (tensor<1x1xi16>, tensor<1x1xi16>) -> tensor<1x1xi16>
    %3 = tosa.bitwise_xor %2, %1 : (tensor<1x1xi16>, tensor<1x1xi16>) -> tensor<1x1xi16>
    %cast = tensor.cast %3 : tensor<1x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

