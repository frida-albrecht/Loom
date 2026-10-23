module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<8x8xi16>}> : () -> tensor<8x8xi16>
    %1 = "tosa.const"() <{values = dense<-1.413500e+02> : tensor<10x9x4x9xf32>}> : () -> tensor<10x9x4x9xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<8x8xi16>) -> tensor<1x8xi16>
    %3 = tosa.log %1 : (tensor<10x9x4x9xf32>) -> tensor<10x9x4x9xf32>
    %4 = tosa.floor %3 : (tensor<10x9x4x9xf32>) -> tensor<10x9x4x9xf32>
    %5 = tosa.const_shape  {values = dense<[1, 3, 3, 360]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %3, %5 : (tensor<10x9x4x9xf32>, !tosa.shape<4>) -> tensor<1x3x3x360xf32>
    %7 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<10x9x4x9xf32>) -> tensor<1x9x4x9xf32>
    %cast = tensor.cast %2 : tensor<1x8xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<1x3x3x360xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %7 : tensor<1x9x4x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

