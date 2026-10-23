module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-101> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<1xi16>) -> tensor<1xi16>
    %2 = tosa.clamp %1 {max_val = 113 : i16, min_val = 25 : i16} : (tensor<1xi16>) -> tensor<1xi16>
    %3 = tosa.clz %2 : (tensor<1xi16>) -> tensor<1xi16>
    %cast = tensor.cast %3 : tensor<1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

