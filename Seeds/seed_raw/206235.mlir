module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<174> : tensor<9x9xi16>}> : () -> tensor<9x9xi16>
    %1 = "tosa.const"() <{values = dense<-195> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %2 = tosa.bitwise_or %0, %1 : (tensor<9x9xi16>, tensor<1x1xi16>) -> tensor<9x9xi16>
    %3 = tosa.const_shape  {values = dense<[27, 1, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<9x9xi16>, !tosa.shape<4>) -> tensor<27x1x1x3xi16>
    %5 = tosa.clamp %4 {max_val = 118 : i16, min_val = 15 : i16} : (tensor<27x1x1x3xi16>) -> tensor<27x1x1x3xi16>
    %cast = tensor.cast %5 : tensor<27x1x1x3xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

