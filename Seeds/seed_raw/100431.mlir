module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-16> : tensor<1x4x4x1xi8>}> : () -> tensor<1x4x4x1xi8>
    %1 = tensor.empty() : tensor<3x3xi8>
    %2 = tensor.empty() : tensor<1x2x2x1xi8>
    %c0_i8 = arith.constant 0 : i8
    %3 = linalg.fill ins(%c0_i8 : i8) outs(%2 : tensor<1x2x2x1xi8>) -> tensor<1x2x2x1xi8>
    %4 = linalg.pooling_nhwc_max {dilations = dense<1> : tensor<2xi64>, strides = dense<1> : tensor<2xi64>} ins(%0, %1 : tensor<1x4x4x1xi8>, tensor<3x3xi8>) outs(%3 : tensor<1x2x2x1xi8>) -> tensor<1x2x2x1xi8>
    %cast = tensor.cast %4 : tensor<1x2x2x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

