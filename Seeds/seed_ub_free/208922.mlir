module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<7x8xi16>}> : () -> tensor<7x8xi16>
    %1 = "tosa.const"() <{values = dense<-173> : tensor<7x95xi16>}> : () -> tensor<7x95xi16>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<7x8xi16>, tensor<7x95xi16>) -> tensor<7x103xi16>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<7x103xi16>) -> tensor<1x103xi16>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<1x103xi16>) -> tensor<1x103xi16>
    %cast = tensor.cast %4 : tensor<1x103xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

