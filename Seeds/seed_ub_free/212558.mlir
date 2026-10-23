module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-59> : tensor<4x1x8xi16>}> : () -> tensor<4x1x8xi16>
    %1 = "tosa.const"() <{values = dense<-86> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %2 = "tosa.const"() <{values = dense<-9.090000e+00> : tensor<8x1xf32>}> : () -> tensor<8x1xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.pad %0, %3, %4 : (tensor<4x1x8xi16>, !tosa.shape<6>, tensor<1xi16>) -> tensor<4x1x8xi16>
    %6 = tosa.floor %2 : (tensor<8x1xf32>) -> tensor<8x1xf32>
    %cast = tensor.cast %5 : tensor<4x1x8xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<8x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

