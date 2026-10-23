module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-140> : tensor<6x6x5x4xi16>}> : () -> tensor<6x6x5x4xi16>
    %1 = "tosa.const"() <{values = dense<1.620500e+02> : tensor<9x10x9x5xf32>}> : () -> tensor<9x10x9x5xf32>
    %2 = "tosa.const"() <{values = dense<1.014300e+02> : tensor<1x10x1x5xf32>}> : () -> tensor<1x10x1x5xf32>
    %3 = tosa.const_shape  {values = dense<[2, 3, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %0, %3 : (tensor<6x6x5x4xi16>, !tosa.shape<4>) -> tensor<12x18x10x8xi16>
    %5 = tosa.const_shape  {values = dense<[3, 2, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %4, %5 : (tensor<12x18x10x8xi16>, !tosa.shape<4>) -> tensor<36x36x20x24xi16>
    %7 = tosa.maximum %1, %2 : (tensor<9x10x9x5xf32>, tensor<1x10x1x5xf32>) -> tensor<9x10x9x5xf32>
    %8 = tosa.reduce_min %7 {axis = 0 : i32} : (tensor<9x10x9x5xf32>) -> tensor<1x10x9x5xf32>
    %cast = tensor.cast %6 : tensor<36x36x20x24xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<1x10x9x5xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

