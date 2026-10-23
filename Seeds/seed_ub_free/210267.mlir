module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-59> : tensor<2x3xi16>}> : () -> tensor<2x3xi16>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<2x3xi16>) -> tensor<1x3xi16>
    %cast = tensor.cast %1 : tensor<1x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

