module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<193> : tensor<10x5x3xi16>}> : () -> tensor<10x5x3xi16>
    %1 = "tosa.const"() <{values = dense<112> : tensor<6x3x3xi64>}> : () -> tensor<6x3x3xi64>
    %2 = "tosa.const"() <{values = dense<-99> : tensor<6x3x1xi64>}> : () -> tensor<6x3x1xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.negate %0, %3, %4 : (tensor<10x5x3xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<10x5x3xi16>
    %6 = tosa.const_shape  {values = dense<[1, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.tile %5, %6 : (tensor<10x5x3xi16>, !tosa.shape<3>) -> tensor<10x5x6xi16>
    %8 = tosa.maximum %1, %2 : (tensor<6x3x3xi64>, tensor<6x3x1xi64>) -> tensor<6x3x3xi64>
    %cast = tensor.cast %7 : tensor<10x5x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<6x3x3xi64> to tensor<*xi64>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

