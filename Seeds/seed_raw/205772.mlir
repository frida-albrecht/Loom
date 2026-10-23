module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<32> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<-1.010400e+02> : tensor<8x2xf32>}> : () -> tensor<8x2xf32>
    %2 = tosa.const_shape  {values = dense<[2, 5, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.reshape %0, %2 : (tensor<10xi16>, !tosa.shape<3>) -> tensor<2x5x1xi16>
    %4 = tosa.clz %3 : (tensor<2x5x1xi16>) -> tensor<2x5x1xi16>
    %5 = tosa.rsqrt %1 : (tensor<8x2xf32>) -> tensor<8x2xf32>
    %6 = tosa.log %5 : (tensor<8x2xf32>) -> tensor<8x2xf32>
    %cast = tensor.cast %4 : tensor<2x5x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<8x2xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

