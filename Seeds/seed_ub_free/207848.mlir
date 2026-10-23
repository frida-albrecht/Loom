module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-152> : tensor<6x4x4xi16>}> : () -> tensor<6x4x4xi16>
    %1 = tosa.reverse %0 {axis = 0 : i32} : (tensor<6x4x4xi16>) -> tensor<6x4x4xi16>
    %2 = tosa.abs %1 : (tensor<6x4x4xi16>) -> tensor<6x4x4xi16>
    %cast = tensor.cast %2 : tensor<6x4x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

