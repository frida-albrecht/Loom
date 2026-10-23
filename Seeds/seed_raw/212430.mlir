module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-45> : tensor<5x4xi16>}> : () -> tensor<5x4xi16>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = tosa.negate %0, %1, %2 : (tensor<5x4xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<5x4xi16>
    %cast = tensor.cast %3 : tensor<5x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

