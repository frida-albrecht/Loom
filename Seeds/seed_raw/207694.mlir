module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-133> : tensor<5x1xi16>}> : () -> tensor<5x1xi16>
    %1 = "tosa.const"() <{values = dense<130> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %2 = "tosa.const"() <{values = dense<-149> : tensor<9xi32>}> : () -> tensor<9xi32>
    %3 = "tosa.const"() <{values = dense<-24> : tensor<9xi32>}> : () -> tensor<9xi32>
    %4 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.pad %0, %4, %5 : (tensor<5x1xi16>, !tosa.shape<4>, tensor<1xi16>) -> tensor<5x1xi16>
    %7 = tosa.intdiv %2, %3 : (tensor<9xi32>, tensor<9xi32>) -> tensor<9xi32>
    %8 = tosa.bitwise_xor %6, %6 : (tensor<5x1xi16>, tensor<5x1xi16>) -> tensor<5x1xi16>
    %9 = tosa.const_shape  {values = dense<[9, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %10 = tosa.reshape %7, %9 : (tensor<9xi32>, !tosa.shape<3>) -> tensor<9x1x1xi32>
    %11 = tosa.reverse %10 {axis = 2 : i32} : (tensor<9x1x1xi32>) -> tensor<9x1x1xi32>
    %12 = tosa.logical_right_shift %11, %11 : (tensor<9x1x1xi32>, tensor<9x1x1xi32>) -> tensor<9x1x1xi32>
    %13 = tosa.logical_left_shift %12, %10 : (tensor<9x1x1xi32>, tensor<9x1x1xi32>) -> tensor<9x1x1xi32>
    %cast = tensor.cast %8 : tensor<5x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %13 : tensor<9x1x1xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

