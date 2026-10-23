module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<196> : tensor<2x10x10xi16>}> : () -> tensor<2x10x10xi16>
    %1 = "tosa.const"() <{values = dense<77> : tensor<2x10x3xi16>}> : () -> tensor<2x10x3xi16>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<2x10x10xi16>, tensor<2x10x3xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<2x10x3xi16>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<2x10x3xi16>) -> tensor<1x10x3xi16>
    %6 = tosa.add %5, %5 : (tensor<1x10x3xi16>, tensor<1x10x3xi16>) -> tensor<1x10x3xi16>
    %cast = tensor.cast %6 : tensor<1x10x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

