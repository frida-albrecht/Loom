module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<89> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<183> : tensor<9x5x4x1xi16>}> : () -> tensor<9x5x4x1xi16>
    %3 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = tosa.reduce_sum %2 {axis = 2 : i32} : (tensor<9x5x4x1xi16>) -> tensor<9x5x1x1xi16>
    %5 = tosa.const_shape  {values = dense<[3, 3, 5, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %4, %5 : (tensor<9x5x1x1xi16>, !tosa.shape<4>) -> tensor<3x3x5x1xi16>
    %7 = tosa.argmax %6 {axis = 1 : i32} : (tensor<3x3x5x1xi16>) -> tensor<3x5x1xi32>
    %8 = tosa.concat %6, %6 {axis = 1 : i32} : (tensor<3x3x5x1xi16>, tensor<3x3x5x1xi16>) -> tensor<3x6x5x1xi16>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<3x5x1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %8 : tensor<3x6x5x1xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    return
  }
}

