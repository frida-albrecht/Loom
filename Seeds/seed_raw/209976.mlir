module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<158> : tensor<8x1x6xi16>}> : () -> tensor<8x1x6xi16>
    %1 = "tosa.const"() <{values = dense<-26> : tensor<8x6x7xi16>}> : () -> tensor<8x6x7xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<8x1x6xi16>, tensor<8x6x7xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<8x1x7xi16>
    %cast = tensor.cast %4 : tensor<8x1x7xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

