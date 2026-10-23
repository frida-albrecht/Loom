module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<10x8x9x8xi16>}> : () -> tensor<10x8x9x8xi16>
    %1 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<10x8x9x8xi16>) -> tensor<10x8x1x8xi16>
    %cast = tensor.cast %1 : tensor<10x8x1x8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

