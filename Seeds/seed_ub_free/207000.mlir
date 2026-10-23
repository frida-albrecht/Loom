module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-193> : tensor<8x5x9xi16>}> : () -> tensor<8x5x9xi16>
    %1 = "tosa.const"() <{values = dense<-1.948300e+02> : tensor<5x3x2x3xf32>}> : () -> tensor<5x3x2x3xf32>
    %2 = tosa.const_shape  {values = dense<[1, 3, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.tile %0, %2 : (tensor<8x5x9xi16>, !tosa.shape<3>) -> tensor<8x15x27xi16>
    %4 = tosa.ceil %1 : (tensor<5x3x2x3xf32>) -> tensor<5x3x2x3xf32>
    %5 = tosa.const_shape  {values = dense<[6, 6, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.const_shape  {values = dense<[2, 5, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.slice %3, %5, %6 : (tensor<8x15x27xi16>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<2x5x3xi16>
    %cast = tensor.cast %4 : tensor<5x3x2x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<2x5x3xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

