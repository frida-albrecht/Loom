module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-43> : tensor<4x5x2x1xi16>}> : () -> tensor<4x5x2x1xi16>
    %1 = tosa.reduce_max %0 {axis = 3 : i32} : (tensor<4x5x2x1xi16>) -> tensor<4x5x2x1xi16>
    %cast = tensor.cast %1 : tensor<4x5x2x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

