module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-126> : tensor<3x7xi16>}> : () -> tensor<3x7xi16>
    %1 = "tosa.const"() <{values = dense<-41> : tensor<3x7xi16>}> : () -> tensor<3x7xi16>
    %2 = tosa.add %0, %1 : (tensor<3x7xi16>, tensor<3x7xi16>) -> tensor<3x7xi16>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<3x7xi16>) -> tensor<1x7xi16>
    %cast = tensor.cast %3 : tensor<1x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

