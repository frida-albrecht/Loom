module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-113> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = tosa.identity %0 : (tensor<1xi16>) -> tensor<1xi16>
    %2 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %1, %2 : (tensor<1xi16>, !tosa.shape<1>) -> tensor<2xi16>
    %cast = tensor.cast %3 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

