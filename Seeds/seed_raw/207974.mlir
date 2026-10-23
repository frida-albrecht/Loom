module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<2x4xi16>}> : () -> tensor<2x4xi16>
    %1 = "tosa.const"() <{values = dense<135> : tensor<1x4xi16>}> : () -> tensor<1x4xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<2x4xi16>, tensor<1x4xi16>) -> tensor<2x4xi16>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<2x4xi16>) -> tensor<2x4xi16>
    %cast = tensor.cast %3 : tensor<2x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

