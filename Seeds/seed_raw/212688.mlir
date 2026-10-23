module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-141> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = "tosa.const"() <{values = dense<-88> : tensor<4xi16>}> : () -> tensor<4xi16>
    %2 = tosa.bitwise_xor %0, %1 : (tensor<4xi16>, tensor<4xi16>) -> tensor<4xi16>
    %cast = tensor.cast %2 : tensor<4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

