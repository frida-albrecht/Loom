module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.649000e+01> : tensor<4x7x2x4xf32>}> : () -> tensor<4x7x2x4xf32>
    %1 = "tosa.const"() <{values = dense<-135> : tensor<7x8xi16>}> : () -> tensor<7x8xi16>
    %2 = "tosa.const"() <{values = dense<-3> : tensor<7x1xi16>}> : () -> tensor<7x1xi16>
    %3 = tosa.sigmoid %0 : (tensor<4x7x2x4xf32>) -> tensor<4x7x2x4xf32>
    %4 = tosa.arithmetic_right_shift %1, %2 {round = true} : (tensor<7x8xi16>, tensor<7x1xi16>) -> tensor<7x8xi16>
    %cast = tensor.cast %3 : tensor<4x7x2x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<7x8xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

