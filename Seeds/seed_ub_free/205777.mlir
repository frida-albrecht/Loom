module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-96> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<1x2xi32>}> : () -> tensor<1x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<10xi16>, !tosa.shape<2>, tensor<1xi16>) -> tensor<10xi16>
    %cast = tensor.cast %4 : tensor<10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

