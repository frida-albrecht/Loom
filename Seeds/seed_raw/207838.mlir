module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-34> : tensor<6x6x7xi16>}> : () -> tensor<6x6x7xi16>
    %1 = "tosa.const"() <{values = dense<198> : tensor<6x7x9xi16>}> : () -> tensor<6x7x9xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<6x6x7xi16>, tensor<6x7x9xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<6x6x9xi16>
    %5 = tosa.bitwise_and %4, %4 : (tensor<6x6x9xi16>, tensor<6x6x9xi16>) -> tensor<6x6x9xi16>
    %6 = tosa.const_shape  {values = dense<[3, 3, 36]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %5, %6 : (tensor<6x6x9xi16>, !tosa.shape<3>) -> tensor<3x3x36xi16>
    %cast = tensor.cast %7 : tensor<3x3x36xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

